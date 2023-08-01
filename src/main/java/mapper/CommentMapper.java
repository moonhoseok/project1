package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import model.Comment;
import model.Member;
import model.Reservation;

public interface CommentMapper {

	@Select("select * from comment where msno=#{msno} "
			+ "order by cdate desc limit #{pn},#{limit}")
	List<Comment> clist(@Param("msno")int msno, 
				@Param("pn")int pageNum, @Param("limit")int limit);
	
	@Insert("insert into comment"
			+ " (msno,id,ccontent,cstar,cdate) "
			+ " values (#{msno},#{id},#{ccontent},#{cstar},now())")
			int insert(Comment com);
	
	@Select("select count(*) from comment where msno = #{value}")
	int listcount(int msno);
	
	@Select("select ifnull(sum(cstar),0) from comment where msno = #{value}")
	int listsum(int msno);
	
	@Delete("delete from comment where id=#{value}")
	int delete(String id);

	@Select("select * from comment where id=#{value}")
	List<Comment> comlist(String id);
}
