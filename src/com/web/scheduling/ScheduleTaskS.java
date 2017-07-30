package com.web.scheduling;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class ScheduleTaskS extends QuartzJobBean {
	
	private int timeout; 
	
	public void setTimeout(int timeout) {
		this.timeout = timeout;
	}

	@Override
	protected void executeInternal(JobExecutionContext context) 
			throws JobExecutionException {
		System.out.println("定时任务执行中…");
		//1
		//2
		//3
		//4
	}

	
}
