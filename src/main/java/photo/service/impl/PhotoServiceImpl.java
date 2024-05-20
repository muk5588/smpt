package photo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import photo.dao.PhotoDao;
import photo.dto.Photo;
import photo.service.face.PhotoService;
import util.Paging;

@Service
public class PhotoServiceImpl implements PhotoService {

	@Autowired private PhotoDao photoDao;
	
	
	@Override
	public List<Photo> list(Paging paging) {
		
		List<Photo> photoList = photoDao.selectAll(paging);
		
		return photoList;
	}

	@Override
	public Paging getPaging(int curPage) {
		
		//총 게시글 수 조회
		int totalCount = photoDao.selectCntAll();
		
		//페이징 계산
		Paging paging = new Paging( totalCount, curPage);
		
		return paging;
	}

	@Override
	public void write(Photo photo) {

		photoDao.insert(photo);
	}

	@Override
	public void uploadPhoto(Photo photo) {

		photoDao.insert(photo);
	}

	@Override
	public void save(Photo photo) {
		photoDao.insert(photo);
		
	}

	@Override
	public void delete(int photono) {

		photoDao.delete(photono);
	}

	@Override
	public Photo view(int photoNo) {

        photoDao.incrementViewCount(photoNo);

		return photoDao.selectByPhotoNo(photoNo);
	}

	@Override
	public Photo findByPhotoNo(int photoNo) {
        return photoDao.selectByPhotoNo(photoNo);

	}

	@Override
	public void update(Photo photo) {
        photoDao.update(photo);

	}

}
