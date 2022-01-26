CREATE TABLE [FF].[ExamenVraagType] (
    [ExamenVraagTypeID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ExamenBlokTypeID]  NVARCHAR (15)   NOT NULL,
    [Description]       NVARCHAR (50)   NOT NULL,
    [Antwoord]          NVARCHAR (15)   NOT NULL,
    [PuntenOK]          DECIMAL (10, 2) DEFAULT ((1)) NULL,
    [PuntenNOK]         DECIMAL (10, 2) DEFAULT ((0)) NULL,
    [PuntenBlanco]      DECIMAL (10, 2) DEFAULT ((0)) NULL,
    [SortOrder]         INT             NULL,
    [SoftDeleted]       BIT             DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION      NOT NULL,
    PRIMARY KEY CLUSTERED ([ExamenVraagTypeID] ASC),
    CONSTRAINT [FK_ExamenVraag_ExamenBlokType] FOREIGN KEY ([ExamenBlokTypeID]) REFERENCES [FF].[ExamenBlokType] ([ExamenBlokTypeID])
);

