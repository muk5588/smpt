package photo.dao;

import java.util.List;


import photo.dto.Photo;
import util.Paging;

public interface PhotoDao {

	public List<Photo> selectAll(Paging paging);

	public int selectCntAll();
	
	public void insert(Photo photo);

	public void delete(int photono);


	public Photo selectByPhotoNo(int photoNo);

	public void update(Photo photo);

	public void incrementViewCount(int photoNo);

}
