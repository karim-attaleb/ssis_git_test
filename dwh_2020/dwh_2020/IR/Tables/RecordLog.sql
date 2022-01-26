CREATE TABLE [IR].[RecordLog] (
    [RecordLogID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Date]        DATETIME        NOT NULL,
    [TableName]   NVARCHAR (128)  NOT NULL,
    [RowID]       NVARCHAR (50)   NOT NULL,
    [Action]      NCHAR (1)       NOT NULL,
    [Message]     NVARCHAR (1000) NULL,
    [UserName]    NVARCHAR (15)   NULL,
    [BronID]      NVARCHAR (15)   NOT NULL,
    CONSTRAINT [PK_RecordLog_RecordLogID] PRIMARY KEY CLUSTERED ([RecordLogID] ASC) ON [DataLog]
) ON [DataLog];

