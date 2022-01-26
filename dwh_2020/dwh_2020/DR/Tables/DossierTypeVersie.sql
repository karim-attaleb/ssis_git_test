CREATE TABLE [DR].[DossierTypeVersie] (
    [DossierTypeVersieID] NVARCHAR (15)  NOT NULL,
    [DossierTypeID]       NVARCHAR (15)  NOT NULL,
    [Description]         NVARCHAR (50)  NOT NULL,
    [DependencySet]       NVARCHAR (200) NULL,
    [SortOrder]           INT            NULL,
    [Comment]             NVARCHAR (800) NULL,
    [SoftDeleted]         BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]          ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DossierTypeVersie] PRIMARY KEY CLUSTERED ([DossierTypeVersieID] ASC),
    CONSTRAINT [FK_DossierTypeVersie_DossierType] FOREIGN KEY ([DossierTypeID]) REFERENCES [DR].[DossierType] ([DossierTypeID])
);

