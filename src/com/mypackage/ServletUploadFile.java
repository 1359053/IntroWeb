package com.mypackage;

import com.google.gson.Gson;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;

public class ServletUploadFile extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String UPLOAD_DIRECTORY1 = "D:\\Dropbox\\CS204_AdvancedWebProgramming\\ProductShop\\out\\artifacts\\ProductShop_war_exploded\\images\\small\\";
    //private final String UPLOAD_DIRECTORY2 = "D:\\Dropbox\\CS204_AdvancedWebProgramming\\ProductShop\\out\\artifacts\\ProductShop_war_exploded\\images\\big\\";

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        String responseData = "failed";

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        // process only if its multipart content
        if (isMultipart) {
            // Create a factory for disk-based file items
            FileItemFactory factory = new DiskFileItemFactory();

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload(factory);
            try {
                // Parse the request
                List<FileItem> multiparts = upload.parseRequest(request);

                for (FileItem item : multiparts) {
                    if (!item.isFormField()) {
                        String name = new File(item.getName()).getName();
                        item.write(new File(UPLOAD_DIRECTORY1 + File.separator + name));
                        responseData="succeed";
                    }
                }
            } catch (Exception e) {
                System.out.println("File upload failed");
            }
        }

        String json = new Gson().toJson(responseData);
        response.getWriter().write(json);
    }
}
