package photo.service.face;

import java.util.List;

import photo.dto.Photo;
import util.Paging;

public interface PhotoService {

	public List<Photo> list(Paging paging);

	public Paging getPaging(int curPage);

	public void write(Photo photo);

	public void uploadPhoto(Photo photo);

	public void save(Photo photo);

	public void delete(int photono);

	public Photo view(int photoNo);

	public Photo findByPhotoNo(int photoNo);

	public void update(Photo photo);

}
