package com.blank.controller;


import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GrimpanController {

	
	@RequestMapping("/member/grimpan.do")
	public void grimpan() {

	}
	
	@RequestMapping("/member/makeImgFile.do")
	public void makePngFile(String imgbase64, HttpServletRequest request) throws Exception {
		/**
		 * imgbase64 (imgbase64data:image/png;base64,iVBORw0KGgoAA 로 시작)
		 */ 
		try {
			// create a buffered image
			BufferedImage image = null;

			String[] base64Arr = imgbase64.split(","); // image/png;base64, 이 부분 버리기 위한 작업
			byte[] imageByte = Base64.decodeBase64(base64Arr[1]); // base64 to byte array로 변경
			
			ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
			image = ImageIO.read(bis);
			bis.close();

			String filePath = request.getRealPath("/resources/upload2");
			// write the image to a file
			String savename = "MyGrim";
			File outputfile = new File(filePath + "/" + savename + ".png");
			ImageIO.write(image, "png", outputfile); // 파일생성
			
		} catch (Exception e) {
			throw e;
		}
		
		/**
		 * server.xml에 <Connector URIEncoding="utf-8" connectionTimeout="20000" port="8099" protocol="HTTP/1.1" redirectPort="8443" />
		 *  maxHttpHeaderSize="30000"
		 * 추가해야함
		 */
	}
}
