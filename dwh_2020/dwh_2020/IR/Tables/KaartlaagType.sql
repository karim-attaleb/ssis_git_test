CREATE TABLE [IR].[KaartlaagType] (
    [KaartlaagTypeID]      NVARCHAR (15)  NOT NULL,
    [KaartLaagTypeGroepID] NVARCHAR (15)  NOT NULL,
    [Description]          NVARCHAR (100) NOT NULL,
    [DependencySet]        NVARCHAR (200) NULL,
    [SortOrder]            INT            NULL,
    [Comment]              NVARCHAR (800) NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_KaartlaagType] PRIMARY KEY CLUSTERED ([KaartlaagTypeID] ASC),
    CONSTRAINT [FK_KaartlaagType_KaartlaagTypeGroep] FOREIGN KEY ([KaartLaagTypeGroepID]) REFERENCES [IR].[KaartlaagTypeGroep] ([KaartLaagTypeGroepID])
);

