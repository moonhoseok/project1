package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mapper.DayMapper;
import mapper.MusicalMapper;

public class DayMybatisDao {
	private Class <DayMapper> cls = DayMapper.class;
	private Map <String, Object> map = new HashMap<>();
	
	public boolean timeInsert(Day day) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).timeInsert(day);
			if(cnt > 0) return true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}

	public List<Day> timelist(int msno) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).timelist(msno);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}

	public boolean timedelete(int msno, String dmd) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).timedelete(msno, dmd);
			return cnt >0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}

	public Day selectOne(int msno, String dmd) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).selectOne(msno, dmd);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}

	public boolean timeupdate(String chdmd, Day d) {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         map.clear();
	         map.put("chdmd", chdmd);
	         map.put("msno", d.getMsno());
	         map.put("dmd", d.getDmd());
	         map.put("time1", d.getTime1());
	         map.put("time2", d.getTime2());
	         map.put("time3", d.getTime3());
	         int cnt = session.getMapper(cls).timeupdate(map);
	         return cnt > 0;
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return false;
	   }
	   public List<Day> tmlist(int msno) {
	       SqlSession session = MybatisConnection.getConnection();
	         try {
	            return session.getMapper(cls).tmlist(msno);
	         } catch (Exception e) {
	            e.printStackTrace();
	         } finally {
	            MybatisConnection.close(session);
	         }
	         return null;
	   }

	   public List<Day> callist(String dmd, int msno) {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).callist(dmd, msno);
	      } catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	    return null;
	   }

	   public List<Day> daylist(int msno) {
		      SqlSession session = MybatisConnection.getConnection();
		      try {
		         return session.getMapper(cls).daylist(msno);
		      } catch(Exception e) {
		         e.printStackTrace();
		      } finally {
		         MybatisConnection.close(session);
		      }
		      return null;
		   }
}
