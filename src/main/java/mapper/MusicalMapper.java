package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Musical;

public interface MusicalMapper {
	
	@Select("SELECT ifnull(max(msno),0) FROM musical")
	int maxnum();
	
	@Insert("insert into musical (msno, mtitle, mage, mdate, mtime, mcast, mpd, mpos,mvid)"
			+ " values(#{msno},#{mtitle},#{mage},#{mdate},#{mtime},#{mcast},#{mpd},#{mpos},#{mvid})")
	int muinsert(Musical mu);

	@Select("SELECT * from musical order by msno desc limit #{pn},#{limit}")
	List<Musical> mulist(@Param("pn") int pageNum, @Param("limit") int limit);

	@Delete("DELETE FROM musical WHERE msno=${value}")
	int mudelete(int msno);

	@Select("SELECT * FROM musical where msno=${value}")
	Musical selectOne(int msno);

	@Update("update musical set mtitle=#{mtitle}, mage=#{mage}, mdate=#{mdate}, mtime=#{mtime}, "
			+ "mcast=#{mcast}, mpd=#{mpd}, mpos=#{mpos} where msno=#{msno}")
	int muupdate(Musical mu);

	String sqlcol = "<if test='colum != null'> where mtitle like '%${column}%'</if>"; 
	@Select({"<script>",
		"select count(*) from musical"+sqlcol,
		"</script>"})
	int muCount(String col);

	
	@Select("select * from musical where mtitle like #{col} " + "order by msno desc limit #{pn},#{limit}")
	List<Musical> slist(@Param("pn") int pageNum, @Param("limit") int limit, @Param("col") String col);

	@Select("SELECT * from musical order by mdate")
	List<Musical> mainmulist();
	
	

}
