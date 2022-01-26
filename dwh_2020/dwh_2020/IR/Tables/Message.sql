CREATE TABLE [IR].[Message] (
    [MessageID]         INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [MessageTypeID]     NVARCHAR (15)  NOT NULL,
    [MessageStatusID]   NVARCHAR (15)  NOT NULL,
    [MessagePriorityID] NVARCHAR (15)  NULL,
    [CreateDatum]       DATETIME       NOT NULL,
    [ReferentieNummer]  NVARCHAR (50)  NULL,
    [Content]           NVARCHAR (MAX) NULL,
    [SoftDeleted]       BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]        ROWVERSION     NOT NULL,
    CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED ([MessageID] ASC),
    CONSTRAINT [FK_Message_MessagePriority] FOREIGN KEY ([MessagePriorityID]) REFERENCES [IR].[MessagePriority] ([MessagePriorityID]),
    CONSTRAINT [FK_Message_MessageStatus] FOREIGN KEY ([MessageStatusID]) REFERENCES [IR].[MessageStatus] ([MessageStatusID]),
    CONSTRAINT [FK_Message_MessageType] FOREIGN KEY ([MessageTypeID]) REFERENCES [IR].[MessageType] ([MessageTypeID])
);

