export const getSubdomain = () => {
	try {
		const parsedUrl = new URL(window.location.href);
		const hostname = parsedUrl.hostname;
		
		// localhost pe koi subdomain nahi
		if (hostname === 'localhost') return null;
		
		// Vercel main domain ignore karo
		if (hostname.includes('vercel.app')) {
			// Only treat as subdomain if format is: something.something.vercel.app
			const parts = hostname.split('.');
			if (parts.length > 3) {
				return parts[0];
			}
			return null;
		}
		
		// Custom domain ke liye
		const parts = hostname.split('.');
		return parts.length > 2 ? parts[0] : null;
	} catch (e) {
		console.error('Invalid URL', e);
		return null;
	}
};