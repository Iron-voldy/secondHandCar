package com.carsales.util;

import org.apache.commons.fileupload.FileItem;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {
    public static List<String> saveUploadedFiles(List<FileItem> items, String savePath) throws Exception {
        List<String> fileNames = new ArrayList<>();
        File saveDir = new File(savePath);
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }
        for (FileItem item : items) {
            if (!item.isFormField()) {
                String fileName = new File(item.getName()).getName();
                if (!fileName.isEmpty()) {
                    File saveFile = new File(savePath, fileName);
                    item.write(saveFile);
                    fileNames.add(fileName);
                }
            }
        }
        return fileNames;
    }
}