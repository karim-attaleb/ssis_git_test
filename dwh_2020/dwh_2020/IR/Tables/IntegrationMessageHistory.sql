CREATE TABLE [IR].[IntegrationMessageHistory] (
    [IntegrationMessageHistoryID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [IntegrationMessageID]        INT             NOT NULL,
    [MessageHash]                 NVARCHAR (50)   NULL,
    [Source]                      NVARCHAR (50)   NOT NULL,
    [Date]                        DATETIME        NOT NULL,
    [RequesterUserName]           NVARCHAR (50)   NOT NULL,
    [RequesterIPAdress]           NVARCHAR (50)   NULL,
    [ExternalReference]           NVARCHAR (50)   NULL,
    [EntityTable]                 NVARCHAR (128)  NULL,
    [EntityID]                    INT             NULL,
    [Status]                      NVARCHAR (15)   NULL,
    [StatusMessage]               NVARCHAR (2000) NULL,
    [SoftDeleted]                 BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]                  ROWVERSION      NOT NULL,
    CONSTRAINT [PK_IntegrationMessageHistory] PRIMARY KEY CLUSTERED ([IntegrationMessageHistoryID] ASC) ON [DataLog],
    CONSTRAINT [FK_IntegrationMessageHistory_IntegrationMessage] FOREIGN KEY ([IntegrationMessageID]) REFERENCES [IR].[IntegrationMessage] ([IntegrationMessageID])
) ON [DataLog];

