package photo.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import board.dto.BoardFile;
import photo.dao.PhotoFileDao;
import photo.dto.Photo;
import photo.dto.PhotoFile;
import photo.service.face.PhotoFileService;

@Service
public class PhotoFileServiceImpl implements PhotoFileService{
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired private PhotoFileDao photofileDao;
	
	@Autowired private ServletContext servletContext;
	
	
	@Override
	public List<String> extractOriginName(String content) {
		List<String> originNames = new ArrayList<>();
        // originName 추출을 위한 정규식 패턴
        Pattern pattern = Pattern.compile("title=\"([^\"\\\\]+\\.(?:png|jpg|gif|PNG|JPG|GIF))\"");
        logger.info("pattern : {}",pattern);
        Matcher matcher = pattern.matcher(content);
        while (matcher.find()) {
            originNames.add(matcher.group(1));
        }
        return originNames;
	}

	@Override
	public List<String> extractStoredName(String content, List<String> originNames) {
		List<String> storedNames = new ArrayList<>();
		String temp = "";
        // storedName 추출을 위한 정규식 패턴
        for (String originName : originNames) {
//        	Pattern pattern = Pattern.compile("img src=\"\\\\resources\\\\boardUpload\\\\([^\"\\\\]+)\\.(?:png|jpg|gif|PNG|JPG|GIF)\"");
        	Pattern pattern = Pattern.compile("img src=\"\\\\resources\\\\boardUpload\\\\([^\"\\\\]+)\\.(png|jpg|gif|PNG|JPG|GIF)\"");
        	logger.info("pattern : {}",pattern);
            Matcher matcher = pattern.matcher(content);
            logger.info("matcher : {}",matcher);
            logger.info("matcher.find() : {}",matcher.find());
            if (matcher.find()) {
            	temp = "";
            	temp += matcher.group(1);
            	temp += ".";
            	temp += matcher.group(2);
                storedNames.add(temp);
                logger.info("matcher.group(1) : {}",matcher.group(1));
            }
        }
        return storedNames;
	}

	@Override
	public void setFile(ArrayList<PhotoFile> files) {
		photofileDao.setFile(files);
		
	}

	@Override
	public void filesave(Photo photo, MultipartFile file) {
		String storedPath = servletContext.getRealPath("/resources/boardUpload");
		logger.info("storedPath : {}", storedPath);
		
		File storedFolder = new File(storedPath);
		storedFolder.mkdir();
		logger.debug("폴더 확인 : {}", storedFolder.toPath());
		
		String storedName = null;
		File dest = null;
		
		do {
			storedName = file.getOriginalFilename(); //원본파일 명
			logger.debug("originName : {} ", storedName);
			storedName += UUID.randomUUID().toString().split("-")[4]; //UUID 추가
			logger.debug("storedName : {} ", storedName);
			logger.debug("UUID.randomUUID().toString().split(\"-\")[4] : {} ", UUID.randomUUID().toString().split("-")[4]);
			
			dest = new File(storedFolder, storedName);
		}while( dest.exists() );
		
		try {
			//업로드된 임시 파일을 upload 폴더로 옮기기
			file.transferTo(dest);
			logger.debug("파일 옮기기 완료 : {}", dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		PhotoFile filetest = new PhotoFile();
		
		filetest.setBoardNo(photo.getBoardNo());
		filetest.setOriginName(file.getOriginalFilename());
		filetest.setStoredName(storedName);
		logger.info("fileTest : {}", filetest);
		
		photofileDao.insert(filetest); //파일 정보 DB에 저장
			//저장된 파일 이름 반환
		
	}

	@Override
	public PhotoFile fileTempSave(HttpServletRequest request, HttpServletResponse response) {
		PhotoFile TempFile = new PhotoFile();
		
		String sFileInfo  = "";
		//파일명을 받는다 - 일반 원본파일명
		String sFilename = request.getHeader("file-name");
		logger.debug("sFilename : {}", sFilename);
		//파일 확장자
		String sFilenameExt = sFilename.substring(sFilename.lastIndexOf(".")+1);
		logger.debug("sFilenameExt : {}", sFilenameExt);
		//확장자를소문자로 변경
		sFilenameExt = sFilenameExt.toLowerCase();
		logger.debug("sFilenameExt : {}", sFilenameExt);
		try {
			//확장자 체크를 위한 
			String[] allowFileArr = {"jpg","png","gif"};
			
			//확장자 체크
			int nCnt = 0;
			for(int i=0; i<allowFileArr.length; i++) {
				if(sFilenameExt.equals(allowFileArr[i])){
					nCnt++;
				}
			}

			//이미지가 아니라면
			if(nCnt == 0) {
				PrintWriter print = response.getWriter();
				print.print("NOTALLOW_"+sFilename);
				print.flush();
				print.close();
			} else {
				//디렉토리 설정 및 업로드	
				
				//파일경로
				String filePath = servletContext.getRealPath("/resources/boardUpload/");
				logger.debug("filePath : {}", filePath);
				File file = new File(filePath);
				
				if(!file.exists()) {
					file.mkdirs();
				}
				
				String sRealFileNm = "";
//				sRealFileNm = UUID.randomUUID().toString() + sFilename.substring(sFilename.lastIndexOf("."));
				sRealFileNm = UUID.randomUUID().toString() + sFilename;
				String rlFileNm = filePath + sRealFileNm;
				
				///////////////// 서버에 파일쓰기 ///////////////// 
				InputStream inputStream = request.getInputStream();
				OutputStream outputStream=new FileOutputStream(rlFileNm);
				int numRead;
				byte bytes[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
				while((numRead = inputStream.read(bytes,0,bytes.length)) != -1){
					outputStream.write(bytes,0,numRead);
				}
				if(inputStream != null) {
					inputStream.close();
				}
				outputStream.flush();
				outputStream.close();
				
				///////////////// 이미지 /////////////////
				// 정보 출력
				sFileInfo += "&bNewLine=true";
				// img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
				sFileInfo += "&sFileName="+ sFilename;
				sFileInfo += "&sFileURL="+"\\resources\\boardUpload\\"+sRealFileNm;
				PrintWriter printWriter = response.getWriter();
				printWriter.print(sFileInfo);
				printWriter.flush();
				printWriter.close();
				logger.debug("sFileInfo : {}", sFileInfo);
				TempFile.setOriginName(sFilename);
				TempFile.setStoredName(sRealFileNm);
				logger.debug("TempFile : {}", TempFile);
				
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.debug("TempFile : {}", TempFile);
		
		return TempFile;
	}

	@Override
	public List<PhotoFile> getFileList(int boardNo) {
		return photofileDao.getFileList(boardNo);

	}

	@Override
	public void listDeleteByBoardNo(ArrayList<Integer> boardno) {
		photofileDao.listDeleteByBoardNo(boardno);
		
	}

	@Override
	public List<PhotoFile> getFilesByBoardNo(int boardno) {
		return photofileDao.getFilesByBoardNo(boardno);

	}

	@Override
	public PhotoFile getFileByFileNo(int fileNo) {
		return photofileDao.getFileByFileNo(fileNo);

	}

	@Override
	public void deleteFile(int fileNo) {
		  PhotoFile file = photofileDao.getFileByFileNo(fileNo);
	       if (file != null) {
	           String storedPath = servletContext.getRealPath("/resources/boardUpload");
	           File storedFile = new File(storedPath, file.getStoredName());
	           if (storedFile.exists()) {
	               storedFile.delete();
	           }
	           photofileDao.delete(fileNo);
	       }
		
	}
	

}
