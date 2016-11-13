package ajaxtest;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class SearchService extends HttpServlet {
	static List<String> datas = new ArrayList<String>();
	static {
	 //实例数据
	 datas.add("ajax");
	 datas.add("ajax post");
	 datas.add("bill");
	 datas.add("james");
	 datas.add("jerry");
 }
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println("123");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		//获得关键字
		String keyword = request.getParameter("keyword");
		//String keyword = new String(keyword1.getBytes(),"utf-8");
		//keyword = java.net.URLDecoder.decode(keyword,"UTF-8");
		System.out.println(keyword);
		//处理之后的
		List<String> listData = getData(keyword);
		//处理为json格式
		//System.out.println(JSONArray.fromObject(listData));
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}
	//获得关联数据
	public List<String> getData(String keyword)
	{
		List<String> list=new ArrayList<String>();
		for(String data:datas)
		{
			if(data.contains(keyword))
			{
				list.add(data);
			}
		}
		return list;
	}
}
