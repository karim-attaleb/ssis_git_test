CREATE TABLE [IR].[DashboardMessage] (
    [DashboardMessageID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Message]            NVARCHAR (800) NULL,
    [BeginDate]          DATETIME       NULL,
    [EndDate]            DATETIME       NULL,
    [SoftDeleted]        BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]         ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DashboardMessage] PRIMARY KEY CLUSTERED ([DashboardMessageID] ASC)
);

