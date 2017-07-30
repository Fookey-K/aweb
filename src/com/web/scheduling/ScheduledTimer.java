package com.web.scheduling;

import java.util.TimerTask;

public class ScheduledTimer extends TimerTask {

	@Override
	public void run() {
		System.out.println("TimerTask正在执行中。。。。。");
	}
}
