
sendEmail() {
	SUBJECT="$SUBJECT"
	BODY="$EMAIL_MESSAGE"
	curl -X POST "http://api.postmarkapp.com/email" -H "Accept: application/json" -H "Content-Type: application/json" -H "X-Postmark-Server-Token: $POSTMARK_SERVER_TOKEN" -v -d "{From: '$EMAIL_FROM', To: '$EMAIL_TO', Subject: '$SUBJECT', HtmlBody: '$BODY'}"
}
