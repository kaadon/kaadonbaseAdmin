<?php


namespace app\common\exception;


use Kaadon\Jwt\JwtException;
use Throwable;

class JwtAnomaly extends JwtException
{
    private $statusCode;
    private $headers;

    public function __construct($message = "", $code = 0, $statusCode = 200, Throwable $previous = null, array $headers = [])
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

