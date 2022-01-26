CREATE TABLE [IR].[IndieningType] (
    [IndieningTypeID]      NVARCHAR (15)  NOT NULL,
    [IndieningCategorieID] NVARCHAR (15)  NULL,
    [Description]          NVARCHAR (500) NOT NULL,
    [DependencySet]        NVARCHAR (200) NULL,
    [RefUrl]               NVARCHAR (400) NULL,
    [SortOrder]            INT            NULL,
    [Comment]              NVARCHAR (800) NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningType] PRIMARY KEY CLUSTERED ([IndieningTypeID] ASC),
    CONSTRAINT [FK_IndieningType_IndieningCategorie] FOREIGN KEY ([IndieningCategorieID]) REFERENCES [IR].[IndieningCategorie] ([IndieningCategorieID])
);

