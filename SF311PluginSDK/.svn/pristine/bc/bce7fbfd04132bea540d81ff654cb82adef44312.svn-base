package com.sf311.portal.hooks;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import com.liferay.portal.ModelListenerException;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.model.ModelListener;
import com.liferay.portal.model.User;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.util.mail.MailEngine;
import com.liferay.util.mail.MailEngineException;

/**
 * This hook intercepts the account creation process AFTER the account has been
 * created.
 */
public class UserAccountHook implements ModelListener {

	private static java.util.concurrent.ConcurrentMap<Long, String> userEmails = null;
	
	static
	{
		userEmails = new java.util.concurrent.ConcurrentHashMap<Long, String>();
	}
	@Override
	public void onAfterCreate(Object arg0) throws ModelListenerException {
		
	}

	@Override
	public void onAfterRemove(Object arg0) throws ModelListenerException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onAfterUpdate(Object arg0) throws ModelListenerException {
		User uzer = (User) arg0;
		/*System.out.println("\n\t---------------After Updated user is New Email: "
				+ uzer.getEmailAddress() + " , Old Email: "+ userEmails.get(uzer.getUserId())+" with id of: " + uzer.getUserId()
				+ "\n\n-------------------------");*/
		
		if(userEmails.get(uzer.getUserId()) != null)
		{
			StringBuffer sb = new StringBuffer();
			sb.append("Your email address has been update to: "+uzer.getEmailAddress());
			InternetAddress frm;
			
			try 
			{
				InternetAddress temp = new InternetAddress(userEmails.get(uzer.getUserId()));
				InternetAddress[] to = new InternetAddress[1];
				to[0] = temp;

				frm = new InternetAddress("noreplay@youngsoft.com");

				MailEngine.send(frm, to,null,null,"Email Address Update Notification", sb.toString() , true, null, null, null);
			} catch (MailEngineException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		userEmails.remove(uzer.getUserId());

	}

	@Override
	public void onBeforeCreate(Object arg0) throws ModelListenerException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onBeforeRemove(Object arg0) throws ModelListenerException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onBeforeUpdate(Object arg0) throws ModelListenerException {
		// TODO Auto-generated method stub
		User uzer = (User) arg0;
		/*System.out.println("\n\t--------------- Before Update user is uzer: "
				+ uzer.getEmailAddress() + " with id of: " + uzer.getUserId()
				+ "\n\n-------------------------");*/

		try {
			String email = UserLocalServiceUtil.getUser(uzer.getUserId()).getEmailAddress();
			userEmails.put(uzer.getUserId(), email);

		} catch (PortalException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void onAfterAddAssociation(Object arg0, String arg1, Object arg2)
			throws ModelListenerException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onAfterRemoveAssociation(Object arg0, String arg1, Object arg2)
			throws ModelListenerException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onBeforeAddAssociation(Object arg0, String arg1, Object arg2)
			throws ModelListenerException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onBeforeRemoveAssociation(Object arg0, String arg1, Object arg2)
			throws ModelListenerException {
		// TODO Auto-generated method stub

	}

}