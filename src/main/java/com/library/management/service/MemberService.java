package com.library.management.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.library.management.entity.Member;
import com.library.management.repository.MemberRepository;

@Service
public class MemberService {

    @Autowired
    private MemberRepository repository;

    public Member saveMember(Member member) {
        member.setId(null); // let the database generate the id
        return repository.save(member);
    }

    public List<Member> getAllMembers() {
        return repository.findAll();
    }

    public Member getMemberById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Member not found"));
    }

    public Member updateMember(Long id, Member member) {
        getMemberById(id);
        member.setId(id);
        return repository.save(member);
    }

    public String deleteMember(Long id) {
        if (repository.existsById(id)) {
            repository.deleteById(id);
            return "Member Deleted Successfully";
        }
        return "Member Not Found";
    }
}
