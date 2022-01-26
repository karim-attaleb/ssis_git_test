CREATE TABLE [IR].[IntegrationMessage] (
    [IntegrationMessageID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Content]              NVARCHAR (MAX) NOT NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IntegrationMessage] PRIMARY KEY CLUSTERED ([IntegrationMessageID] ASC) ON [DataLog]
) ON [DataLog] TEXTIMAGE_ON [DataBin];

