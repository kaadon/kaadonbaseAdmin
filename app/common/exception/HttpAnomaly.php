<?php


namespace app\common\exception;

use Throwable;

class HttpAnomaly extends \RuntimeException
{
    private $statusCode;
    private $headers;

    public function __construct($message = null, $code = 0, $statusCode = 404, Throwable $previous = null, array $headers = [])
    {
        $this->statusCode = $statusCode;
        $this->headers    = $headers;

        parent::__construct($message, $code, $previous);
    }

    public function getStatusCode()
    {
        return $this->statusCode;
    }

    public function getHeaders()
    {
        return $this->headers;
    }
}

