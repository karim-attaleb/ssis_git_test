CREATE TABLE [OOMP].[IndieningBezwaarType] (
    [IndieningBezwaarTypeID] NVARCHAR (15)  NOT NULL,
    [Description]            NVARCHAR (200) NOT NULL,
    [DependencySet]          NVARCHAR (200) NULL,
    [SortOrder]              INT            NULL,
    [Comment]                NVARCHAR (800) NULL,
    [SoftDeleted]            BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]             ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningBezwaarType] PRIMARY KEY CLUSTERED ([IndieningBezwaarTypeID] ASC)
);

