package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import model.Member;
import model.Reservation;

public interface ReservationMapper {

	@Select("select rseat1,rseat2,rseat3 from reser "
			+ "where rmsno=#{msno} and rmd=#{day} and rtime=#{time}")
	List<Reservation> selist(Map<String, Object> map);

	@Select("select * from reser where id=#{value}")
	List<Reservation> reslist(String id);
	
	@Select("select * from reser")
	   List<Reservation> reserlist();
	@Delete("delete from reser where id=#{id} && rno=#{rno}")
	boolean delete(@Param("rno")int rno,@Param("id") String id);

	@Select("select ifnull(max(rno),0) from reser")
	int maxnum();
	
	@Insert("insert into reser(id,rmtitle,rmsno,rmd,rtime,rpmdate,rtprice,rseat1,rseat2,rseat3) "
			+ "values(#{id},#{rmtitle},#{rmsno},#{rmd},#{rtime},now(),#{rtprice},#{rseat1},#{rseat2},#{rseat3})")
	int insert(Reservation res);
	
}
