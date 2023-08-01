package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Member;
import model.Point;

public interface MemberMapper {

	@Insert("insert into member(id, pass, name, email, gender, regdate, tel, bir)"
			+ " values(#{id},#{pass},#{name},#{email},#{gender},now(),#{tel},#{bir})")
	int insert(Member mem);

	@Select("select * from member where id = #{value}")
	Member selectOne(String id);

	@Select("select id from member " + "where email=#{email} and tel=#{tel}")
	String idSearch(@Param("email") String email, @Param("tel") String tel);

	@Select("select pass from member " + "where id=#{id}and email=#{email} and tel=#{tel}")
	String pwSearch(Map<String, Object> map);

	@Insert("insert into pointlist(id,point,regdate) values(#{value},300000,now())")
	int pointinsert(String id);

	@Insert("insert into pointlist(id,point,regdate) values(#{id},#{point},now())")
	int pointadd(@Param("id") String id, @Param("point") int point);

	@Select("SELECT ifnull(sum(point),0) point  from pointlist " + " WHERE id = #{value}")
	Point pointselect(String id);

	@Select("SELECT seq, point, regdate from pointlist " + " WHERE id =  #{value} order by seq desc ")
	List<Point> pointboard(String id);

	@Delete("delete from member where id=#{value}")
	int delete(String id);

	@Update("update member set tel=#{tel} " + "where id=#{id}")
	int telupdate(Member mem);

	@Update("update member set email=#{email} " + "where id=#{id}")
	int emailupdate(Member mem);

	@Update("update member set con=#{con} " + "where id=#{id}")
	int conupdate(Member mem);

	String sqlcol = "<if test='column != null'> where id like '%${column}%'</if>";          
	   @Select({"<script>",
	      "select count(*) from member"+sqlcol,
	      "</script>"})
	   int memCount(String col);

	@Select("select * from member order by regdate desc limit #{pn},#{limit}")
	List<Member> list(@Param("pn") int pageNum, @Param("limit") int limit);

	@Select("select * from member where id like #{col} " + "order by regdate desc limit #{pn},#{limit}")
	List<Member> slist(@Param("pn") int pageNum, @Param("limit") int limit, @Param("col") String col);

	@Select("select ifnull(sum(point),0) from pointlist where id = #{value}")
	int topoint(String id);

	@Delete("delete from reser where rno=#{value}")
	int resdel(int rno);

}
