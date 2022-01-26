CREATE TABLE [FF].[VisVerlofTypeTarief] (
    [VisVerlofTypeTariefID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [VisVerlofTypeID]       NVARCHAR (15)   NOT NULL,
    [Jaartal]               INT             NOT NULL,
    [DatumVan]              DATETIME        NULL,
    [DatumTot]              DATETIME        NULL,
    [Bedrag]                DECIMAL (10, 2) NULL,
    [DependencySet]         NVARCHAR (200)  NULL,
    [SortOrder]             INT             NULL,
    [Comment]               NVARCHAR (800)  NULL,
    [SoftDeleted]           BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([VisVerlofTypeTariefID] ASC),
    CONSTRAINT [FK_VisVerlofTypeTarief_VisVerlofType] FOREIGN KEY ([VisVerlofTypeID]) REFERENCES [FF].[VisVerlofType] ([VisVerlofTypeID]),
    CONSTRAINT [UK_VisVerlofTypeTarief] UNIQUE NONCLUSTERED ([VisVerlofTypeID] ASC, [Jaartal] ASC)
);

