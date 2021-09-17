package main;

import java.util.List;

import javax.swing.JButton;
import javax.swing.JFrame;

import dao.DAO;
import dao.MybatisConnection;
import dto.InquireDateDTO;
import dto.SmartPlugDTO;

public class GetGraphFrame {
	private JFrame frame;
	private JButton closeBtn;

	private DAO dao;
	private List<SmartPlugDTO> smartPlugDTO, reductionSmartPlugDTO;
	private InquireDateDTO inquireDateDTO;

	private String product;
	private int product_id;

	private ProductGraphFrame productGraphFrame;
	private ReductionGraphFrame reductionGraphFrame;

	public GetGraphFrame(int graphCheck, int optionCheck, String product, String date, int store_id) {
		try {
			dao = new DAO(MybatisConnection.getSqlSessionFactory());
			if (!product.equals("=====기기선택=====")) {
				this.product = changeEnglish(product);
			} else {
				this.product = null;
			}
			if (graphCheck == 0) {
				product_id = dao.getProductId(product);
				inquireDateDTO = new InquireDateDTO(date, product_id, store_id);
				if (optionCheck == 0) {
					this.product += "-Hour Using Energy";
					smartPlugDTO = dao.readSmartPlugHourData(inquireDateDTO);
				} else if (optionCheck == 1) {
					this.product += "-Day Using Energy";
					smartPlugDTO = dao.readSmartPlugDayData(inquireDateDTO);
				} else {
					this.product += "-Month Using Energy";
					smartPlugDTO = dao.readSmartPlugMonthData(inquireDateDTO);
				}
				productGraphFrame = new ProductGraphFrame(smartPlugDTO, this.product);
			} else {
				inquireDateDTO = new InquireDateDTO(date, 0, store_id);
				if (optionCheck == 0) {
					this.product = "Hour Using Energy";
					smartPlugDTO = dao.readTotalHourAmpData(inquireDateDTO);
					reductionSmartPlugDTO = dao.readTotalHourAmpReductionData(inquireDateDTO);
				} else if (optionCheck == 1) {
					this.product = "Day Using Energy";
					smartPlugDTO = dao.readTotalDayAmpData(inquireDateDTO);
					reductionSmartPlugDTO = dao.readTotalDayAmpReductionData(inquireDateDTO);
				} else {
					this.product = "Month Using Energy";
					smartPlugDTO = dao.readTotalMonthAmpData(inquireDateDTO);
					reductionSmartPlugDTO = dao.readTotalMonthAmpReductionData(inquireDateDTO);
				}
				reductionGraphFrame = new ReductionGraphFrame(smartPlugDTO, reductionSmartPlugDTO, this.product);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String changeEnglish(String product) {
		switch (product) {
		case "음료냉장고":
			product = "beverage refrigerator";
			break;
		case "업소용냉장고":
			product = "commercial refrigerator";
			break;
		case "커피머신":
			product = "coffee machine";
			break;
		case "커피그라인더":
			product = "coffee grinder";
			break;
		case "핫워터디스펜서":
			product = "hot water dispenser";
			break;
		case "미니오븐":
			product = "mini oven";
			break;
		case "아이스메이커":
			product = "ice maker";
			break;

		}
		return product;
	}
}
