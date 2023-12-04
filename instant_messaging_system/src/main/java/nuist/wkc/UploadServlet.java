package nuist.wkc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet{


    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        //模拟数据库存储文件名
        HttpSession session=request.getSession();
        List<String> list=(List<String>)session.getAttribute("files");
        if(list==null){
            //如果集合为空，就创建一个集合
            list=new ArrayList<String>();
        }    
        
        try {
            //获取文件描述信息
            String desc=request.getParameter("desc");
            //获取上传的文件
            Part part=request.getPart("file");
            //获取请求的信息
            String name=part.getHeader("content-disposition");
            //System.out.println(name);//测试使用
            //System.out.println(desc);//
            
            //获取上传文件的目录
            String root=request.getServletContext().getRealPath("/upload");
            System.out.println("测试上传文件的路径："+root);
            
            //获取文件的后缀
            String str=name.substring(name.lastIndexOf("."), name.length()-1);
            System.out.println("测试获取文件的后缀："+str);
            
            //生成一个新的文件名，不重复，数据库存储的就是这个文件名，不重复的
            String fname=UUID.randomUUID().toString()+str;
            //将文件名保存到集合中
            list.add(fname);
            //将保存在集合中的文件名保存到域中
            session.setAttribute("files", list);
            
            String filename=root+"\\"+fname;
            System.out.println("测试产生新的文件名："+filename);
            
            //上传文件到指定目录，不想上传文件就不调用这个
            part.write(filename);
            
            request.setAttribute("info", "上传文件成功");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("info", "上传文件失败");
        }
        
        request.getRequestDispatcher("/upload.jsp").forward(request, response);
    }
    
}