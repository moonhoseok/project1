package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mapper.MusicalMapper;

public class MusicalMybatisDao {
	private Class <MusicalMapper> cls = MusicalMapper.class;
	private Map <String, Object> map = new HashMap<>();
	
	//게시판의 가장 큰 값
	public int maxnum() {
		SqlSession session = MybatisConnection.getConnection();	 //db 접속
		try {
			return session.getMapper(cls).maxnum(); 		//db의 cls에서 maxnum 가지고 와라
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return 0;
	}
	
	// 뮤지컬 정보 넣기
	public boolean muinsert(Musical mu) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).muinsert(mu);
			if(cnt > 0) return true;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	
	// mulist 뮤지컬 리스트
	public List<Musical> mulist(int pageNum, int limit) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			pageNum = (pageNum -1) * limit;
			return session.getMapper(cls).mulist(pageNum,limit);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}
	
	// 뮤지컬 삭제
	public boolean mudelete(int msno) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).mudelete(msno);
			return cnt >0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}

	// 뮤지컬 msno 선택
	public Musical selectOne(int msno) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).selectOne(msno);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}

	// 뮤지컬 정보 수정
	public boolean muupdate(Musical mu) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).muupdate(mu) > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	
	// 뮤지컬 리스트
	public int muCount(String col) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).muCount(col);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return 0;
	}

	public List<Musical> selectlist(int pageNum, int limit, String col) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			col = "%"+col+"%";
			pageNum = (pageNum -1) * limit;
			return session.getMapper(cls).slist(pageNum,limit,col);
		} catch (Exception e) {	
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}
	//===========================
	public List<Musical> mainmulist() {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).mainmulist();
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return null;
	   }
	
}
