package model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mapper.MemberMapper;

public class MemberMyBatisDao {
	
	private Class<MemberMapper> cls = MemberMapper.class;
	private Map<String, Object> map =new HashMap<>();
	
	public boolean insert(Member mem) { //
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         int cnt = session.getMapper(cls).insert(mem);
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
	   
	   public Member selectOne(String id) {//
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).selectOne(id);
	      
	      } catch (Exception e) {
	         e.printStackTrace();
	      }finally {
	         MybatisConnection.close(session);
	      }
	      return null;
	   }
	   
	   public String idSearch(String email, String tel) {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).idSearch(email,tel);   
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return null;
	   }
	   
	   public String pwSearch(String id, String email, String tel) {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         map.clear();
	         map.put("id", id);
	         map.put("email", email);
	         map.put("tel", tel);
	         return session.getMapper(cls).pwSearch(map);
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return null;
	   }
	   
	     public boolean pointinsert(String id) {
	        SqlSession session = MybatisConnection.getConnection();
	         try {
	            int cnt = session.getMapper(cls).pointinsert(id);
	            return  cnt >0;
	         } catch (Exception e) {
	            e.printStackTrace();
	         }finally {
	            MybatisConnection.close(session);
	         }
	         return false;
	      }
	     
	     public boolean pointadd(String id, int point) {
	        SqlSession session = MybatisConnection.getConnection();
	         try {
	            int cnt = session.getMapper(cls).pointadd(id,point);
	            return  cnt >0;
	         } catch (Exception e) {
	            e.printStackTrace();
	         }finally {
	            MybatisConnection.close(session);
	         }
	         return false;
	      }
	     
	     public Point pointselect(String id) {
	        SqlSession session = MybatisConnection.getConnection();
	         try {
	            return session.getMapper(cls).pointselect(id);
	         
	         } catch (Exception e) {
	            e.printStackTrace();
	         }finally {
	            MybatisConnection.close(session);
	         }
	         return null;
	      }
	     
	     public List<Point> pointboard(String id) {
	        SqlSession session = MybatisConnection.getConnection();
	         try { 
	            return session.getMapper(cls).pointboard(id);
	         } catch (Exception e) {
	            e.printStackTrace();
	         }finally {
	            MybatisConnection.close(session);
	         }
	         return null;
	      }
	     public int topoint(String id) {
		        SqlSession session = MybatisConnection.getConnection();
		         try { 
		            return session.getMapper(cls).topoint(id);
		         } catch (Exception e) {
		            e.printStackTrace();
		         }finally {
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
	public boolean telupdate(Member mem) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).telupdate(mem);
			return cnt > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	
	public boolean emailupdate(Member mem) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).emailupdate(mem);
			return cnt > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	
	public boolean conupdate(Member mem) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).conupdate(mem);
			return cnt > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
	public List<Member> list(int pageNum,int limit) {
			SqlSession session = MybatisConnection.getConnection();
			try {
				pageNum = (pageNum -1) * limit;
				return session.getMapper(cls).list(pageNum,limit);
			} catch (Exception e) {	
				e.printStackTrace();
			} finally {
				MybatisConnection.close(session);
			}
			return null;		
		}   
	public List<Member> slist(int pageNum,int limit,String col) {
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
	public int memCount(String col) {
	      SqlSession session = MybatisConnection.getConnection();
	      try {
	         return session.getMapper(cls).memCount(col);
	      } catch(Exception e) {
	         e.printStackTrace();
	      } finally {
	         MybatisConnection.close(session);
	      }
	      return 0;
	   }

	public boolean resdel(int rno) {
		SqlSession session = MybatisConnection.getConnection();
		try {
			int cnt = session.getMapper(cls).resdel(rno);
			return cnt > 0;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return false;
	}
}
