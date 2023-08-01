package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mapper.ReservationMapper;

public class ReservationMybatisDao {

	Class<ReservationMapper> cls = ReservationMapper.class;
	private Map<String, Object> map =new HashMap<>();

	public List<Reservation> selist(int msno,String day, String time){
		SqlSession session = MybatisConnection.getConnection();
		try {
			map.clear();
			map.put("msno", msno);
			map.put("day", day);
			map.put("time", time);
			return session.getMapper(cls).selist(map);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}
	public List<Reservation> reslist(String id){
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).reslist(id);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}
	public List<Reservation> reserlist(){
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).reserlist();
	      }catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return null;
	   }
	   public boolean delete(int rno, String id) {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).delete(rno,id);
	      }catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return false;
	   }
	   public int maxnum() {
		   SqlSession session = MybatisConnection.getConnection();
		      try {
		         return session.getMapper(cls).maxnum();
		      }catch(Exception e) {
		         e.printStackTrace();
		      } finally {
		         MybatisConnection.close(session);
		      }
		      return 0;
	   }
	   public boolean insert(Reservation res) { 
		      SqlSession session = MybatisConnection.getConnection();
		      try {
		         int cnt = session.getMapper(cls).insert(res);
		         if(cnt > 0) {
		            return true;
		         }else {
		            return false;
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      }finally {
		         MybatisConnection.close(session);
		      }
		      return false;
		   }
}
