
-- =============================================
-- Author: Paul Bossuyt
-- Create date: 16/07/2012
-- Description: Delete Attachments that are no longer referenced by an AttachmentInfo
-- =============================================
CREATE PROCEDURE [dbo].[uspBatchCleanupAttachments]
AS
BEGIN
DELETE FROM IR.Attachment
WHERE(AttachmentID IN
(SELECT Attachment_1.AttachmentID
FROM IR.Attachment AS Attachment_1 LEFT OUTER JOIN
IR.AttachmentInfo ON Attachment_1.AttachmentID = AttachmentInfo.AttachmentID
WHERE (AttachmentInfo.AttachmentInfoID IS NULL) AND Attachment_1.UploadDateTime < DATEADD(day, -1, GETDATE())))
END