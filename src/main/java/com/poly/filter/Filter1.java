package com.poly.filter;

import jakarta.servlet.*;
import java.io.IOException;

public class Filter1 implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setAttribute("hello", "Tôi là filter 1");
        chain.doFilter(request, response);
    }
}
