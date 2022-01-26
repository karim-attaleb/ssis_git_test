CREATE TABLE [FF].[JachtVergunningType] (
    [JachtVergunningTypeID] NVARCHAR (15)   NOT NULL,
    [Description]           NVARCHAR (50)   NOT NULL,
    [DependencySet]         NVARCHAR (200)  NULL,
    [SortOrder]             INT             NULL,
    [Bedrag]                DECIMAL (10, 2) NULL,
    [Comment]               NVARCHAR (800)  NULL,
    [SoftDeleted]           BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]            ROWVERSION      NOT NULL,
    CONSTRAINT [PK_JachtVergunningType] PRIMARY KEY CLUSTERED ([JachtVergunningTypeID] ASC)
);

