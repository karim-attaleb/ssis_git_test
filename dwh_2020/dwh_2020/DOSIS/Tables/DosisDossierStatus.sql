CREATE TABLE [DOSIS].[DosisDossierStatus] (
    [DosisDossierStatusID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [DossierStatusID]      NVARCHAR (15)  NOT NULL,
    [VlaamsCode]           NVARCHAR (256) NOT NULL,
    [VlaamsFase]           NVARCHAR (256) NOT NULL,
    [VanDatum]             DATE           NOT NULL,
    [TotDatum]             DATE           NULL,
    [SoftDeleted]          BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]           ROWVERSION     NOT NULL,
    CONSTRAINT [PK_DosisDossierStatus] PRIMARY KEY CLUSTERED ([DosisDossierStatusID] ASC),
    CONSTRAINT [FK_DosisDossierStatus_DossierStatus] FOREIGN KEY ([DossierStatusID]) REFERENCES [DR].[DossierStatus] ([DossierStatusID])
);

