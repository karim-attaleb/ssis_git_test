CREATE TABLE [FF].[JachtVerlofType] (
    [JachtVerlofTypeID] NVARCHAR (15)   NOT NULL,
    [Description]       NVARCHAR (50)   NOT NULL,
    [DependencySet]     NVARCHAR (200)  NULL,
    [SortOrder]         INT             NULL,
    [Comment]           NVARCHAR (800)  NULL,
    [SoftDeleted]       BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION      NOT NULL,
    [Bedrag]            DECIMAL (10, 2) NULL,
    CONSTRAINT [PK_JachtVerlofType] PRIMARY KEY CLUSTERED ([JachtVerlofTypeID] ASC)
);

