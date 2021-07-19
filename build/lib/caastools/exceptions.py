

class RecordNotFoundException(Exception):

    def __init__(self, msg):
        super().__init__(msg)


class VersionException(Exception):

    def __init__(self, msg):
        super().__init__(msg)
