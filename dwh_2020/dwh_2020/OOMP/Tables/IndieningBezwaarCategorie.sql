CREATE TABLE [OOMP].[IndieningBezwaarCategorie] (
    [IndieningBezwaarCategorieID]       NVARCHAR (15)  NOT NULL,
    [IndieningBezwaarCategorieParentID] NVARCHAR (15)  NULL,
    [Description]                       NVARCHAR (150) NOT NULL,
    [DependencySet]                     NVARCHAR (200) NULL,
    [SortOrder]                         INT            NULL,
    [Comment]                           NVARCHAR (800) NULL,
    [SoftDeleted]                       BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                        ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningBezwaarCategorie] PRIMARY KEY CLUSTERED ([IndieningBezwaarCategorieID] ASC),
    CONSTRAINT [FK_IndieningBezwaarCategorie_IndieningBezwaarCategorieParent] FOREIGN KEY ([IndieningBezwaarCategorieParentID]) REFERENCES [OOMP].[IndieningBezwaarCategorie] ([IndieningBezwaarCategorieID])
);

