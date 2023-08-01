package sitemesh;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

import model.Musical;
import model.MusicalMybatisDao;

@WebFilter("/*")
public class SiteMeshFilter extends ConfigurableSiteMeshFilter{
	@Override
	   public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
	         throws IOException, ServletException {
		  try{
			  request.setCharacterEncoding("UTF-8");
		  }catch(UnsupportedEncodingException e) {
			  e.printStackTrace();
		  }
	      MusicalMybatisDao mdao = new MusicalMybatisDao();
	      List<Musical> mainlist = mdao.mainmulist(); 
	      request.setAttribute("mainlist", mainlist);
	      super.doFilter(request, response, filterChain);
	   }
	@Override
	public void applyCustomConfiguration(SiteMeshFilterBuilder builder){
		builder.addDecoratorPath("/member/*", "/layout/publiclayout.jsp");
		builder.addDecoratorPath("/reservation/*", "/layout/publiclayout.jsp")
		.addExcludedPath("/reservation/calendar*")
		.addExcludedPath("/reservation/day*")
		.addExcludedPath("/reservation/seat");
		builder.addDecoratorPath("/admin/*", "/layout/publiclayout.jsp").addExcludedPath("/admin/post*");

	}
}
