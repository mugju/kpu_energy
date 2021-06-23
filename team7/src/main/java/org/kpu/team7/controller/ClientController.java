package org.kpu.team7.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.kpu.team7.domain.ClientVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.SmartPlugVO;
import org.kpu.team7.service.ClientService;
import org.kpu.team7.service.SmartPlugService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "/client")
public class ClientController {

	@Autowired
	private ClientService clientService;
	@Autowired
	private SmartPlugService smartPlugService;

	private static final Logger logger = LoggerFactory.getLogger(ClientController.class);

	/* 로그인 페이지 */
	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String loginPageGET() throws Exception {
		logger.info(" /login URL GET method called. then forward login.jsp.");
		return "client/login";
	}

	@RequestMapping(value = { "/login" }, method = RequestMethod.POST)
	public String loginPagePOST(@RequestParam("storeName") String name, ClientVO vo, Model model, HttpSession session)
			throws Exception {
		try {
			int store_id = clientService.getStoreId(name);
			vo.setStoreId(store_id);
			ClientVO client = clientService.readClient(vo);
			session.setAttribute("client", client);
			logger.info(client.toString());
			logger.info(" /login URL POST method called. then redirect home.jsp.");
			return "redirect:/client/home";
		} catch (Exception e) {
			model.addAttribute("msg", "noUser");
			logger.info(" /login URL POST method called. then forward login.jsp.");
			return "client/login";
		}
	}

	/* 메인 페이지 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String homePageGET(HttpSession session, Model model) throws Exception {
		model.addAttribute("session", session);
		logger.info(" /home URL GET method called. then forward home.jsp.");
		return "client/home";
	}

	@RequestMapping(value = { "/home" }, method = RequestMethod.POST)
	public String homePagePOST(HttpSession session, Model model) throws Exception {
		model.addAttribute("session", session);
		logger.info(" /home URL POST method called. then redirect home.jsp.");
		return "/client/home";
	}

	/* 스마트 플러그 id 111 */
	@RequestMapping(value = "/smart_plug", method = RequestMethod.GET)
	public String smartPlugPageGET(HttpSession session, Model model) throws Exception {
		logger.info(" /smart_plug URL GET method called. then forward smart_plug.jsp.");
		return "/client/smart_plug";
	}

	@RequestMapping(value = { "/smart_plug" }, method = RequestMethod.POST)
	public String smartPlugPagePOST(HttpSession session, Model model, @RequestParam("sDate") String sDate, @RequestParam("eDate") String eDate) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		InquireDateVO svo=new InquireDateVO();
		svo.setEDate(eDate);
		svo.setSDate(sDate);
		svo.setId(3);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> list = smartPlugService.readDataList(svo);
		model.addAttribute("list",list);
		logger.info(" /smart_plug URL POST method called. then redirect smart_plug.jsp.");
		return "/client/smart_plug";
	}
	
	/* 스마트 플러그 id 2 */
	@RequestMapping(value = "/smart_plug2", method = RequestMethod.GET)
	public String smartPlugPageGET2(HttpSession session, Model model) throws Exception {
		//ClientVO vo=(ClientVO)session.getAttribute("client");
		//List<SmartPlugVO> list = smartPlugService.readDataList(2);
		//model.addAttribute("list",list);
		logger.info(" /smart_plug URL GET method called. then forward smart_plug.jsp.");
		return "/client/home";
	}

	@RequestMapping(value = { "/smart_plug2" }, method = RequestMethod.POST)
	public String smartPlugPagePOST2(HttpSession session, Model model) throws Exception {
		model.addAttribute("session", session);
		//List<SmartPlugVO> list = smartPlugService.readDataList(2);
		//model.addAttribute("list",list);
		logger.info(" /smart_plug URL POST method called. then redirect home.jsp.");
		return "/client/smart_plug2";
	}
	
	/* 스마트 플러그 id 3 */
	@RequestMapping(value = "/smart_plug3", method = RequestMethod.GET)
	public String smartPlugPageGET3(HttpSession session, Model model) throws Exception {
		//ClientVO vo=(ClientVO)session.getAttribute("client");
		//List<SmartPlugVO> list = smartPlugService.readDataList(3);
		//model.addAttribute("list",list);
		logger.info(" /smart_plug URL GET method called. then forward smart_plug.jsp.");
		return "/client/home";
	}

	@RequestMapping(value = { "/smart_plug3" }, method = RequestMethod.POST)
	public String smartPlugPagePOST3(HttpSession session, Model model) throws Exception {
		model.addAttribute("session", session);
		//List<SmartPlugVO> list = smartPlugService.readDataList(3);
		//model.addAttribute("list",list);
		logger.info(" /smart_plug URL POST method called. then redirect home.jsp.");
		return "/client/smart_plug3";
	}

	/* 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logoutPagePOST(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/client/login";
	}
}
