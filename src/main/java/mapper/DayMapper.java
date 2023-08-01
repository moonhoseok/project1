package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.Day;

public interface DayMapper {

	@Insert("insert into day (msno, dmd, time1, time2, time3) "
			+ " values(#{msno},#{dmd},#{time1},#{time2},#{time3})")
	int timeInsert(Day day);
	
	@Select("select * from day where msno = ${value}")
	List<Day> timelist(int msno);

	@Delete("DELETE FROM day where msno=#{msno} and dmd=#{dmd}")
	int timedelete(@Param("msno") int msno, @Param("dmd")String dmd);

	@Select("SELECT * From day where msno=#{msno} and dmd=#{dmd}")
	Day selectOne(@Param("msno") int msno, @Param("dmd")String dmd);

	@Update("UPDATE day set dmd=#{dmd}, time1=#{time1}, time2=#{time2}, time3=#{time3}"
            + " where msno=#{msno} and dmd=#{chdmd}")
    int timeupdate(Map<String, Object> map);
	
	   @Select("select * from day where msno=${value} order by dmd")
	   List<Day> tmlist(int msno);

	   @Select("select * from day where dmd=#{dmd} and msno=#{msno}")
	   List<Day> callist(@Param("dmd")String dmd, @Param("msno") int msno);
	   
	   @Select("select dmd from day where msno=${value} and dmd >= DATE_FORMAT(NOW(),'%Y-%m-%d')")
	   List<Day> daylist(int msno);


}
