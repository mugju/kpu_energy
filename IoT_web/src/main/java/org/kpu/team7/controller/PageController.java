package org.kpu.team7.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.kpu.team7.domain.ClientVO;
import org.kpu.team7.domain.InquireDateVO;
import org.kpu.team7.domain.ProductVO;
import org.kpu.team7.domain.SmartPlugVO;
import org.kpu.team7.service.AllService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value="/web")
public class PageController {
	
	@Autowired
	private AllService service;
	
	private static final Logger logger = LoggerFactory.getLogger(PageController.class);
	
	/*로그인 페이지*/
	@RequestMapping(value = { "/login" }, method = RequestMethod.GET)
	public String loginPageGET() throws Exception {
		logger.info(" /login URL GET method called. then forward login.jsp.");
		return "web/login";
	}
	
	@RequestMapping(value = { "/login" }, method = RequestMethod.POST)
	public String loginPagePOST(@RequestParam("storeName") String name, ClientVO vo, Model model, HttpSession session)
			throws Exception {
		try {
			int store_id = service.getStoreId(name);
			vo.setStoreId(store_id);
			ClientVO client = service.confirmAccount(vo);
			session.setAttribute("client", client);
			logger.info(client.toString());
			logger.info(" /login URL POST method called. then redirect home.jsp.");
			return "redirect:/web/home";
		} catch (Exception e) {
			model.addAttribute("msg", "noUser");
			logger.info(" /login URL POST method called. then forward login.jsp.");
			return "web/login";
		}
	}
	
	/* 메인 페이지 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String homePageGET(HttpSession session, Model model) throws Exception {
		model.addAttribute("session", session);
		logger.info(" /home URL GET method called. then forward home.jsp.");
		return "web/home";
	}

	@RequestMapping(value = { "/home" }, method = RequestMethod.POST)
	public String homePagePOST(HttpSession session, Model model) throws Exception {
		model.addAttribute("session", session);
		logger.info(" /home URL POST method called. then redirect home.jsp.");
		return "redirect:/web/home";
	}
	
	/* 스마트 플러그 일별 시간당 전력 데이터 */
	@RequestMapping(value = { "/smart_plug_hour" }, method = RequestMethod.GET)
	public String smartPlugPageHourGET(HttpSession session, Model model) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		List<ProductVO> pvo = service.getProductName(vo.getStoreId());
		model.addAttribute("product",pvo);
		logger.info(" /smart_plug_hour URL GET method called. then redirect smart_plug.jsp.");
		return "web/smart_plug_hour";
	}
	
	@RequestMapping(value = { "/smart_plug_hour" }, method = RequestMethod.POST)
	public String smartPlugPageHourPOST(HttpSession session, Model model, @RequestParam("Date") String date,
			@RequestParam("productName") String product) throws Exception {
		int pId=service.getProductId(product);
		ClientVO vo = (ClientVO)session.getAttribute("client");
		List<ProductVO> pvo = service.getProductName(vo.getStoreId());
		model.addAttribute("product",pvo);
		InquireDateVO svo=new InquireDateVO();
		svo.setDate(date);
		svo.setId(pId);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> list = service.readSmartPlugHourData(svo);
		logger.info(list.toString());
		model.addAttribute("list",list);
		model.addAttribute("pName",product);
		logger.info(" /smart_plug_hour URL POST method called. then redirect smart_plug.jsp.");
		return "web/smart_plug_hour";
	}
	
	/* 스마트 플러그 월별 일일 전력 데이터 */
	@RequestMapping(value = { "/smart_plug_day" }, method = RequestMethod.GET)
	public String smartPlugPageDayGET(HttpSession session, Model model) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		List<ProductVO> pvo = service.getProductName(vo.getStoreId());
		model.addAttribute("product",pvo);
		logger.info(" /smart_plug_day URL GET method called. then redirect smart_plug.jsp.");
		return "web/smart_plug_day";
	}
	
	@RequestMapping(value = { "/smart_plug_day" }, method = RequestMethod.POST)
	public String smartPlugPageDayPOST(HttpSession session, Model model, @RequestParam("Date") String date,
			@RequestParam("productName") String product) throws Exception {
		int pId=service.getProductId(product);
		ClientVO vo = (ClientVO)session.getAttribute("client");
		List<ProductVO> pvo = service.getProductName(vo.getStoreId());
		model.addAttribute("product",pvo);
		InquireDateVO svo=new InquireDateVO();
		svo.setDate(date);
		svo.setId(pId);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> list = service.readSmartPlugDayData(svo);
		logger.info(list.toString());
		model.addAttribute("list",list);
		model.addAttribute("pName",product);
		logger.info(" /smart_plug_day URL POST method called. then redirect smart_plug.jsp.");
		return "web/smart_plug_day";
	}
	
	/* 스마트 플러그 연간 월별 전력 데이터 */
	@RequestMapping(value = { "/smart_plug_month" }, method = RequestMethod.GET)
	public String smartPlugPageMonthGET(HttpSession session, Model model) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		List<ProductVO> pvo = service.getProductName(vo.getStoreId());
		model.addAttribute("product",pvo);
		logger.info(" /smart_plug_day URL GET method called. then redirect smart_plug.jsp.");
		return "web/smart_plug_month";
	}
	
	@RequestMapping(value = { "/smart_plug_month" }, method = RequestMethod.POST)
	public String smartPlugPageMonthPOST(HttpSession session, Model model, @RequestParam("Date") String date,
			@RequestParam("productName") String product) throws Exception {
		int pId=service.getProductId(product);
		ClientVO vo = (ClientVO)session.getAttribute("client");
		List<ProductVO> pvo = service.getProductName(vo.getStoreId());
		model.addAttribute("product",pvo);
		InquireDateVO svo=new InquireDateVO();
		svo.setDate(date);
		svo.setId(pId);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> list = service.readSmartPlugMonthData(svo);
		logger.info(list.toString());
		model.addAttribute("list",list);
		model.addAttribute("pName",product);
		logger.info(" /smart_plug_day URL POST method called. then redirect smart_plug.jsp.");
		return "web/smart_plug_month";
	}
	
	/* 스마트 플러그 일별 시간당 절감 데이터 */
	@RequestMapping(value = { "/reduction_hour" }, method = RequestMethod.GET)
	public String reductionHourGET(HttpSession session, Model model) throws Exception {
		logger.info(" /smart_plug URL GET method called. then redirect smart_plug.jsp.");
		return "web/reduction_hour";
	}
	
	@RequestMapping(value = { "/reduction_hour" }, method = RequestMethod.POST)
	public String reductuinHourPOST(HttpSession session, Model model, @RequestParam("Date") String date) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		InquireDateVO svo=new InquireDateVO();
		svo.setDate(date);
		svo.setId(0);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> totalList = service.readTotalHourAmpData(svo);
		List<SmartPlugVO> reductionList = service.readTotalHourReductionAmpData(svo);

		logger.info(totalList.toString());
		logger.info(reductionList.toString());
		model.addAttribute("total",totalList);
		model.addAttribute("reductionTotal",reductionList);
		logger.info(" /smart_plug URL POST method called. then redirect smart_plug.jsp.");
		return "web/reduction_hour";
	}
	
	/* 스마트 플러그 월별 일간 절감 데이터 */
	@RequestMapping(value = { "/reduction_day" }, method = RequestMethod.GET)
	public String reductionDayGET(HttpSession session, Model model) throws Exception {
		logger.info(" /smart_plug URL GET method called. then redirect smart_plug.jsp.");
		return "web/reduction_day";
	}
	
	@RequestMapping(value = { "/reduction_day" }, method = RequestMethod.POST)
	public String reductuinDayPOST(HttpSession session, Model model, @RequestParam("Date") String date) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		InquireDateVO svo=new InquireDateVO();
		svo.setDate(date);
		svo.setId(0);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> totalList = service.readTotalDayAmpData(svo);
		List<SmartPlugVO> reductionList = service.readTotalDayAmpReductionData(svo);
		logger.info(totalList.toString());
		logger.info(reductionList.toString());
		model.addAttribute("total",totalList);
		model.addAttribute("reductionTotal",reductionList);
		logger.info(" /smart_plug URL POST method called. then redirect smart_plug.jsp.");
		return "web/reduction_day";
	}
	
	/* 스마트 플러그 월별 일간 절감 데이터 */
	@RequestMapping(value = { "/reduction_month" }, method = RequestMethod.GET)
	public String reductionMonthGET(HttpSession session, Model model) throws Exception {
		logger.info(" /reduction_month URL GET method called. then redirect smart_plug.jsp.");
		return "web/reduction_month";
	}
	
	@RequestMapping(value = { "/reduction_month" }, method = RequestMethod.POST)
	public String reductuinMonthPOST(HttpSession session, Model model, @RequestParam("Date") String date) throws Exception {
		ClientVO vo = (ClientVO)session.getAttribute("client");
		InquireDateVO svo=new InquireDateVO();
		svo.setDate(date);
		svo.setId(0);
		svo.setStoreId(vo.getStoreId());
		List<SmartPlugVO> totalList = service.readTotalMonthAmpData(svo);
		List<SmartPlugVO> reductionList = service.readTotalMonthAmpReductionData(svo);
		logger.info(totalList.toString());
		logger.info(reductionList.toString());
		model.addAttribute("total",totalList);
		model.addAttribute("reductionTotal",reductionList);
		logger.info(" /reduction_month URL POST method called. then redirect smart_plug.jsp.");
		return "web/reduction_month";
	}
	
	
	/* 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutPageGET(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/web/login";
	}
	/* 로그아웃 */
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logoutPagePOST(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/web/login";
	}
}
