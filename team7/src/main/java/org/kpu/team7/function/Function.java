package org.kpu.team7.function;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.kpu.team7.domain.SmartPlugVO;

public class Function {

	private int size;

	public List<Date> getDateList(List<SmartPlugVO> list) {
		List<Date> aList = new ArrayList<Date>();
		size = list.size();
		for(int i=0;i<size;i++) 
			aList.add(list.get(i).getDatetime());
		return aList;
	}
	
	public List<Double> getDataList(List<SmartPlugVO> list) {
		List<Double> dList = new ArrayList<Double>();
		size = list.size();
		for(int i=0;i<size;i++) 
			dList.add(list.get(i).getAmp());
		return dList;
	}
}
