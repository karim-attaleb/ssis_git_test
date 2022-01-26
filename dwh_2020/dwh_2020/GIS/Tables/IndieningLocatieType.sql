CREATE TABLE [GIS].[IndieningLocatieType] (
    [IndieningLocatieTypeID] NVARCHAR (15)  NOT NULL,
    [Description]            NVARCHAR (100) NOT NULL,
    [DependencySet]          NVARCHAR (200) NULL,
    [SortOrder]              INT            NULL,
    [Comment]                NVARCHAR (800) NULL,
    [SoftDeleted]            BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningLocatieType] PRIMARY KEY CLUSTERED ([IndieningLocatieTypeID] ASC)
);

