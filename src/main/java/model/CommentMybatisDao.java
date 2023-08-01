package model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import mapper.CommentMapper;

public class CommentMybatisDao {

	private Class<CommentMapper> cls = CommentMapper.class;

	public List<Comment> clist(int msno,int pageNum,int limit) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			pageNum = (pageNum -1) * limit;
			return session.getMapper(cls).clist(msno,pageNum,limit);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}
	public boolean insert(Comment com) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).insert(com);
			if(cnt > 0) return true;
			else return false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	public int listcount(int msno) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).listcount(msno);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return 0;
	}
	
	public int listsum(int msno) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).listsum(msno);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return 0;
	}
	public boolean delete(String id) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).delete(id);
			return cnt > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	public List<Comment> comlist(String id){
		SqlSession session = MybatisConnection.getConnection();
		try {
			return session.getMapper(cls).comlist(id);
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	}
}
