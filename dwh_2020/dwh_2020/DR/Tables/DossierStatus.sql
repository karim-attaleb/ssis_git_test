CREATE TABLE [DR].[DossierStatus] (
    [DossierStatusID] NVARCHAR (15)  NOT NULL,
    [DossierFaseID]   NVARCHAR (15)  NOT NULL,
    [Description]     NVARCHAR (50)  NOT NULL,
    [DependencySet]   NVARCHAR (200) NULL,
    [SortOrder]       INT            NULL,
    [Comment]         NVARCHAR (800) NULL,
    [SoftDeleted]     BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]      ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DossierStatus] PRIMARY KEY CLUSTERED ([DossierStatusID] ASC),
    CONSTRAINT [FK_DossierStatus_DossierFase] FOREIGN KEY ([DossierFaseID]) REFERENCES [DR].[DossierFase] ([DossierFaseID])
);

