CREATE TABLE [DR].[DossierTypeIdmContext] (
    [DossierTypeIdmContextID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DossierTypeID]           NVARCHAR (15)  NOT NULL,
    [IdmContext]              NVARCHAR (255) NOT NULL,
    [SoftDeleted]             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DossierTypeIDMcontext] PRIMARY KEY CLUSTERED ([DossierTypeIdmContextID] ASC),
    CONSTRAINT [FK_DossierTypeIdmContext_DossierType] FOREIGN KEY ([DossierTypeID]) REFERENCES [DR].[DossierType] ([DossierTypeID])
);


GO
CREATE NONCLUSTERED INDEX [IXFK_DossierTypeIDMcontext_DossierType]
    ON [DR].[DossierTypeIdmContext]([DossierTypeID] ASC);

