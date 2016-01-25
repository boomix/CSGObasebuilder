Handle CountdownTimer;
Handle CountdownTimer2;

public void Timer_OnBuildTimeStart()
{

	KillCDTimers();	

	g_iCountdown = RoundToZero(g_fBuildTime);
	CountdownTimer = CreateTimer(1.0, BB_BuildTimeCountdown, _, TIMER_REPEAT);
	
}

public Action BB_BuildTimeCountdown(Handle tmr)
{
	g_iCountdown--;
	PrintHintTextToAll(g_sBuildTimeMsg, g_iCountdown);
}

public void Timer_OnPrepTimeStart()
{
	
	KillCDTimers();
	
	g_iCountdown = RoundToZero(g_fPrepTime);
	CountdownTimer2 = CreateTimer(1.0, BB_PrepTimeCountdown, _, TIMER_REPEAT);

}

public Action BB_PrepTimeCountdown(Handle tmr)
{
	g_iCountdown--;
	PrintHintTextToAll(g_sPrepTimeMsg, g_iCountdown);
	
	
	if(g_iCountdown <= 0) {
		KillCDTimers();
		PrintHintTextToAll(g_sReleaseMsg);
	}
	
}

public void KillCDTimers()
{

	if (CountdownTimer != null)
	{
		KillTimer(CountdownTimer);
		CountdownTimer = null;
	}
	
	if (CountdownTimer2 != null)
	{
		KillTimer(CountdownTimer2);
		CountdownTimer2 = null;
	}

}