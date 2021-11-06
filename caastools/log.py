import functools
import logging
import typing


def _log_(path: str = None, log_level: int = logging.INFO):

    format = logging.Formatter('%(levelname)s|%(asctime)s: %(message)s')
    log = logging.getLogger("ct_logger")
    log.setLevel(log_level)

    if path is not None:
        file_handler = logging.FileHandler(path)
        file_handler.setFormatter(format)
        file_handler.setLevel(log_level)
        log.addHandler(file_handler)
    else:
        file_handler = logging.NullHandler()

    console_handler = logging.StreamHandler()
    console_handler.setFormatter(format)
    console_handler.setLevel(log_level)

    log.addHandler(console_handler)

    return log

    logger = logging.getLogger('LogFunction')
    logger.setLevel(logging.ERROR)

    # Create file handler, log format and add the format to file handler
    file_handler = logging.FileHandler(path) if path is not None else logging.NullHandler()
    console_handler = logging.StreamHandler()

    # See https://docs.python.org/3/library/logging.html#logrecord-attributes
    # for log format attributes.
    log_format = '%(levelname)s %(asctime)s %(message)s'
    formatter = logging.Formatter(log_format)
    file_handler.setFormatter(formatter)

    logger.addHandler(file_handler)
    return logger


def log_function(path=None, log_level: int = logging.INFO):

    def log_call(func):

        @functools.wraps(func)
        def wrapper(*args, **kwargs):

            try:
                # Execute the called function, in this case `divide()`.
                # If it throws an error `Exception` will be called.
                # Otherwise it will be execute successfully.
                return func(*args, **kwargs)
            except Exception as e:
                logger = _log_(path, log_level)
                logger.exception(e)

                return e  # Or whatever message you want.

        return wrapper

    return log_call