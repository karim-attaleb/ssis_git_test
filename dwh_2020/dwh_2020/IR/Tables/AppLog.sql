CREATE TABLE [IR].[AppLog] (
    [AppLogID]   INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Date]       DATETIME        NOT NULL,
    [Level]      NVARCHAR (15)   NOT NULL,
    [Source]     NVARCHAR (100)  NOT NULL,
    [Parameters] NVARCHAR (1000) NULL,
    [Message]    NVARCHAR (1000) NOT NULL,
    [StackTrace] NVARCHAR (MAX)  NULL,
    [UserName]   NVARCHAR (50)   NULL,
    [Browser]    NVARCHAR (50)   NULL,
    [BronID]     NVARCHAR (15)   NOT NULL,
    CONSTRAINT [PK_AppLog_AppLogID] PRIMARY KEY CLUSTERED ([AppLogID] ASC) ON [DataLog]
) ON [DataLog] TEXTIMAGE_ON [DataLog];

