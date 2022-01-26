CREATE TABLE [DR].[DossierTypeAcmRol] (
    [DossierTypeAcmRolID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DossierTypeID]       NVARCHAR (15)  NOT NULL,
    [AcmRolID]            NVARCHAR (50)  NOT NULL,
    [Description]         NVARCHAR (50)  NULL,
    [DependencySet]       NVARCHAR (200) NULL,
    [SortOrder]           INT            NULL,
    [Comment]             NVARCHAR (800) NULL,
    [SoftDeleted]         BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]          ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DossierTypeAcmRol] PRIMARY KEY CLUSTERED ([DossierTypeAcmRolID] ASC),
    CONSTRAINT [FK_DossierTypeAcmRol_AcmRol] FOREIGN KEY ([AcmRolID]) REFERENCES [IR].[AcmRol] ([AcmRolID]),
    CONSTRAINT [FK_DossierTypeAcmRol_DossierType] FOREIGN KEY ([DossierTypeID]) REFERENCES [DR].[DossierType] ([DossierTypeID])
);

