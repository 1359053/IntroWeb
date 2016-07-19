package com.mypackage;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Iterator;
import java.util.List;

public class ServletUploadBigImage extends HttpServlet {

    private boolean isMultipart;
    private String filePath;
    private int maxFileSize = 5000 * 1024;
    private int maxMemSize = 4000 * 1024;
    private File file;

    public void init() {
        // Get the file location where it would be stored.
        filePath = getServletContext().getInitParameter("file-upload-big");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException {
        response.setContentType("text/html;charset=UTF-8");
        //get data from request
        //request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String model = session.getAttribute("model").toString();
        //System.out.println(model);

        // Check that we have a file upload request
        isMultipart = ServletFileUpload.isMultipartContent(request);


        java.io.PrintWriter out = response.getWriter();
        if (!isMultipart) {
            out.println("No file uploaded");
            return;
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("c:\\temp"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);

        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();

            while (i.hasNext()) {
                FileItem fi = (FileItem) i.next();
                if (!fi.isFormField()) {
                    // Get the uploaded file parameters
                    String fileName = fi.getName();
                    String fileExt = FilenameUtils.getExtension(fileName);
                    String fileNameNew = model + "." + fileExt;
                    fileNameNew = fileNameNew.replaceAll("[^a-zA-Z0-9.-]", "_");
                    //System.out.println(fileName);
                    //System.out.println(fileNameNew);

                    // Write the file
                    if (fileNameNew.lastIndexOf("\\") >= 0) {
                        file = new File(filePath +
                                fileNameNew.substring(fileNameNew.lastIndexOf("\\")));
                    } else {
                        file = new File(filePath +
                                fileNameNew.substring(fileNameNew.lastIndexOf("\\") + 1));
                    }
                    fi.write(file);
                    out.println("Image uploaded.");
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, java.io.IOException {

        throw new ServletException("GET method used with " +
                getClass().getName() + ": POST method required.");
    }
}
